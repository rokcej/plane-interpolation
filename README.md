# Plane interpolation
A GNU Octave program that interpolates a 3D plane and displays the result.  
It was created as a homework assignment for my mathematical modelling class. It is based on the concept of partition of unity and it works by pasting together functions defined on individual squares of unit size, while ensuring that the values of these functions as well as their derivatives everywhere on the edges of individual squares match with the values and derivatives of the function on the edges of adjacent squares.

## How to use it
Run the `tester.m` file. By default, it generates a random 5x5 matrix as the input. You can change that by modifying the matrix `V`. To change the interpolation accuracy, modify the `len` variable.

## Example
* Input:
![Raw input](img/raw.jpg "Raw input")
* Output for `len = 10`:
![Interpolated output](img/interpolated.jpg "Interpolated input")
