#if canImport(PyBundle)
  import PyBundle
  import Python
#endif

struct testme {
  static func pyVersion() {
    print("python version: \(String(cString: Py_GetVersion()))")
  }
}
