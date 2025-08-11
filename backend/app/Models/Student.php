<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student extends Model
{
    /** @use HasFactory<\Database\Factories\StudentFactory> */
    use HasFactory;

    protected $fillable = [
        'khmer_name',
        'latin_name',
        'gender',
        'dob',
        'address',
        'tel',
    ];

    protected $casts = [
        'dob' => 'date',
    ];
}
