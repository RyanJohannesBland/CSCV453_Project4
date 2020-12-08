/* Incorrect expression, can't add an array plus an int */

int x[10], y, z;

int foo(int x[])
{
  y = x+1;
  return y;
}
