import 'package:flutter/material.dart';
import 'message_util.dart';
import 'student_model.dart';
import 'student_service.dart';
import 'package:intl/intl.dart';
// import 'package:dropdown_search/dropdown_search.dart';
class StudentForm extends StatefulWidget {
  //const StudetForm({super.key});
  Datum ? item;
  bool editMode;

  StudentForm({this.item,this.editMode = false});
  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  bool _changed = false;
  late TextEditingController _nameCtrl;
  @override
  void initState() {
    super.initState();
    if(this.widget.editMode){
      _nameCtrl = TextEditingController(text: this.widget.item!.latinName);
    }
    else{
      _nameCtrl = TextEditingController();
    }
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvokedWithResult:(didPop,res){
          if(!didPop){
            Navigator.pop(context, _changed);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop(_changed);
              },
              icon: Icon(Icons.arrow_back_ios_new),
            ),
            title: Text(this.widget.editMode ? "Edit Student" : "Add Student"),
            actions: [this.widget.editMode ? _buildDeleteButton() : SizedBox()],
          ),
          body: _buildBody(),
        )
    );
  }
  Widget _buildDeleteButton(){
    return IconButton(
      onPressed: () async{
        bool deleted = await showDeleteDialog(context) ?? false;
        if(deleted) {
          StudentService.delete(this.widget.item!.id)
              .then((value) {
            setState(() {
              _output = value.toString();
            });
            _changed = value;
            Navigator.of(context).pop(_changed);
          })
              .onError((e, s) {
            setState(() {
              _output = e.toString();
            });
          });
        }
      },
      icon: Icon(Icons.delete),
    );
  }
  final _formkey = GlobalKey<FormState>();
  Widget _buildBody(){
    return Form(
      key: _formkey,
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [
          _buildkhNameTextField(),
          SizedBox(height: 16), 
          _buildNameTextField(),
          SizedBox(height: 16), 
          _buildGenderDropdown(),
          SizedBox(height: 16), 
          _buildDOBPicker(),
          SizedBox(height: 16), 
          _buildAddressTextField(),
          SizedBox(height: 16), 
          _buildNumberTextField(),
          SizedBox(height: 24), 
          _buildButton(),
          SizedBox(height: 16), 
          _buildOutput(),
        ],
      ),
    );
  }
  final List<String> genders = ['Male', 'Female', 'Other'];
  String? _selectedGender;

  Widget _buildGenderDropdown() {
      return DropdownButtonFormField<String>(
          value: _selectedGender,
          items: genders.map((gender) {
              return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
              );
          }).toList(),
          onChanged: (value) {
              setState(() {
                  _selectedGender = value;
              });
          },
          decoration: InputDecoration(
              labelText: 'Gender',
              border: OutlineInputBorder(),
          ),
          validator: (value) => value == null ? 'Please select a gender' : null,
      );
  }
  DateTime? _selectedDate;
  void _gestureOnTab() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate ?? DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
        setState(() => _selectedDate = pickedDate);
    }
}

  Widget _buildDOBPicker() {
      return GestureDetector(
          onTap: _gestureOnTab,
          child: InputDecorator(
              decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  border: OutlineInputBorder(),
              ),
              child: Text(
                  _selectedDate != null
                      ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                      : 'Select your date of birth',
              ),
          ),
      );
  }
  Widget _buildNameTextField() {
    return TextFormField(
      controller: _nameCtrl,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter English Name"
      ),
    );
  }
  Widget _buildkhNameTextField() {
    return TextFormField(
      controller: _nameCtrl,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter khmer Name"
      ),
    );
  }
  Widget _buildAddressTextField() {
    return TextFormField(
      controller: _nameCtrl,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter Address"
      ),
    );
  }
  Widget _buildNumberTextField() {
    return TextFormField(
      controller: _nameCtrl,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: "Enter PhoneNumber"
      ),
    );
  }
  Widget _buildButton(){
    return ElevatedButton(
      onPressed: (){
        if(_formkey.currentState!.validate()){
          if(this.widget.editMode){
            _onUpdateStudent();
          }
          else{
            _onAddStudent();
          }
        }
      },
      child: Text("Save Student"),
    );
  }
  String _output = "output";
  void _onAddStudent(){
    Datum item = Datum(
      id: 0,
      latinName: _nameCtrl.text,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );
    StudentService.insert(item)
        .then((value){
      setState(() {
        _output = value.toString();
      });
      _changed = value;
    })
        .onError((e,s){
      setState(() {
        _output = e.toString();
      });
    });
  }
  void _onUpdateStudent() {
    Datum item = Datum(
      id: this.widget.item!.id,
      latinName: _nameCtrl.text,
      createdAt: this.widget.item!.createdAt,
      updatedAt: DateTime.now().toIso8601String(),
    );
    StudentService.update(item)
        .then((value){
      setState(() {
        _output = value.toString();
      });
      _changed = value;
    })
        .onError((e,s){
      setState(() {
        _output = e.toString();
      });
    });
  }
  Widget _buildOutput() {
    return Text(_output);
  }
}
