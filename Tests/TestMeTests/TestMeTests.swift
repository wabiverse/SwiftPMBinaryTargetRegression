import Testing

#if canImport(TestMe)
  @testable import TestMe
#else
  @testable import TestMeSwift
#endif

@Test
func example() async throws {
  print("\n")
  print("getting python version...")

  print("\n\n")
  testme.pyVersion()
  print("\n\n")
}
