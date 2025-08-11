<?php

namespace Database\Factories;
use Illuminate\Support\Str;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Student>
 */
class StudentFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'khmer_name' => $this->faker->word(),
            'latin_name' => $this->faker->name(),
            'gender'     => $this->faker->randomElement(['male', 'female', 'other']),
            'dob'        => $this->faker->date('Y-m-d', '2007-12-31'),
            'address'    => $this->faker->address(),
            'tel'        => $this->faker->numerify('012-###-####'),
        ];
    }
}
