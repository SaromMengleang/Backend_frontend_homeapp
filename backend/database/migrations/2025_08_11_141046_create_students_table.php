<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('students', function (Blueprint $table) {
            $table->id();
            $table->string('khmer_name', 255);
            $table->string('latin_name', 255)->nullable();
            $table->enum('gender', ['male', 'female', 'other'])->default('other');
            $table->date('dob')->nullable();
            $table->text('address')->nullable();
            $table->string('tel', 50)->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('students');
    }
};
