<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Student;

class StudentApiController extends Controller
{
    public function index(){
        $students = Student::latest()->paginate(20);
        return $students;
    }
    public function store(Request $request){
        $validated = $request->validate(['name'=>'required|string']);
        $student = Student::create($validated);
        return response()->json($student,201); 
    }
    public function show($id){
        $student = Student::find($id);
        
        if(!$student)return response()->json(['message'=>'Student not found'],404);  
    }
    public function update(Request $request, $id){
        $student = Student::find($id);
        if(!$student)return response()->json(['message'=>'Student not found'],404);
        $validated = $request->validate(['name'=>'required|string']);
        $student->update($validated);
        return response()->json($student,200);
    }
    public function destroy($id){
        $student = Student::find($id);
        if(!$student)return response()->json(['message'=>'Student not found'],404);
        $student->delete();
        return response()->json(['message'=>'Student deleted successfully'],200);   
    }
}