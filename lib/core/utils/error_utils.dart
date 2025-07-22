String getErrorMessage(dynamic error) {
  if (error == null) return 'Unknown error';
  final msg = error.toString().toLowerCase();
  if (msg.contains('connection error') || msg.contains('socketexception')) {
    return 'Connection error. Please check your internet connection.';
  }
  if (msg.contains('timeout')) {
    return 'Request timed out. Please try again.';
  }
  // Add more custom error parsing as needed
  return error.toString();
} 