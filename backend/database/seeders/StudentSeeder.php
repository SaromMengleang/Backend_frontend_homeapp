<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Student;
class StudentSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $khmerNames = [
            'សាន សុភា',
            'ជា វណ្ណា',
            'សុខ វិចិត្រ',
            'ហេង វណ្ណារិទ្ធ',
            'ស្រី សុភាព',
            'ចាន់ បញ្ញា',
            'វង្ស សុធារ៉ា',
            'ហូ វណ្ណី',
            'នួន រដ្ឋា',
            'គង់ សុភ័ក្រ',
        ];

        $latinNames = [
            'San Sophea',
            'Chea Vanna',
            'Sok Vichetra',
            'Heng Vannarith',
            'Srey Sopheap',
            'Chan Pannha',
            'Vong Sothara',
            'Hou Vanny',
            'Nuon Rotha',
            'Kong Sophak',
        ];


        // Clear table first (optional)
        Student::truncate();

        for ($i = 0; $i < count($khmerNames); $i++) {
            Student::create([
                'khmer_name' => $khmerNames[$i],
                'latin_name' => $latinNames[$i],
                'gender'     => ['male', 'female', 'other'][array_rand(['male', 'female', 'other'])],
                'dob'        => now()->subYears(rand(10, 50))->format('Y-m-d'),
                'address'    => 'Some address ' . ($i + 1),
                'tel'        => '012-' . rand(100, 999) . '-' . rand(1000, 9999),
            ]);
        }
    }
}
