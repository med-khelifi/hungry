class Validators {
  // Email validation
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // Phone validation
  static bool isValidPhone(String phone) {
   /* if (phone.isEmpty) return false;
    // Remove any spaces, dashes, or parentheses
    final cleanPhone = phone.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    // Check if it contains only digits and has appropriate length
    final phoneRegex = RegExp(r'^\d{10,15}$');
    return phoneRegex.hasMatch(cleanPhone);
    */
  return (phone.isEmpty) ? false : true;
  }

  // Password validation
  static bool isValidPassword(String password) {
    return password.isNotEmpty && password.length >= 8;
  }

  // Strong password validation (optional)
  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    
    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasSpecialCharacters = password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    
    return hasUppercase && hasLowercase && hasDigits;
  }

  // Name validation
  static bool isValidName(String name) {
    if (name.isEmpty || name.length < 2) return false;
    // Allow letters, spaces, hyphens, and apostrophes
    final nameRegex = RegExp(r"^[a-zA-Z\s\-']+$");
    return nameRegex.hasMatch(name);
  }

  // Password match validation
  static bool doPasswordsMatch(String password, String confirmPassword) {
    return password.isNotEmpty && password == confirmPassword;
  }

  // Get email error message
  static String? getEmailError(String email) {
    if (email.isEmpty) return "Email is required";
    if (!isValidEmail(email)) return "Please enter a valid email address";
    return null;
  }

  // Get phone error message
  static String? getPhoneError(String phone) {
    if (phone.isEmpty) return "Phone number is required";
    if (!isValidPhone(phone)) return "Please enter a valid phone number";
    return null;
  }

  // Get password error message
  static String? getPasswordError(String password) {
    if (password.isEmpty) return "Password is required";
    if (password.length < 8) return "Password must be at least 8 characters";
    return null;
  }

  // Get name error message
  static String? getNameError(String name) {
    if (name.isEmpty) return "Name is required";
    if (name.length < 2) return "Name must be at least 2 characters";
    if (!isValidName(name)) return "Please enter a valid name";
    return null;
  }

  // Get confirm password error message
  static String? getConfirmPasswordError(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return "Please confirm your password";
    if (!doPasswordsMatch(password, confirmPassword)) return "Passwords do not match";
    return null;
  }
}