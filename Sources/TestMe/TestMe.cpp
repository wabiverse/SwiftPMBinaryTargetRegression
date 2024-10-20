#include <TestMe.h>
#include <Python.h>
#include <stdio.h>

namespace testme
{
  void pyVersion()
  {
    printf("python version: %s\n", Py_GetVersion());
  }
}
