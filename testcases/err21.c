/* array subscript not of appropriate type, or the function foo is missing
 * its parameter */

int a[10];

int foo(int x)
{
  x = a[foo];
  return x;
}
