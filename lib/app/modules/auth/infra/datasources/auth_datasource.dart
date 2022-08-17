abstract class IAuthDataSource {
  Future<bool> login({required Map<String, dynamic> map});
  Future<Map<String, dynamic>> verifyLicense(String id);
}
