class Errors {
  static String showError(String errorCode) {
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'This email address is already in use, please use a different email address.';
      case 'ERROR_USER_NOT_FOUND':
        return 'This user is not found in system. Please you create a user.';
      case 'ERROR_ACCOUNT_EXISTS_WITH_DIFFERENT_CREDENTIAL':
        return 'The mail address in your facebook had been saved with gmail or email method before.Please you entry with this mail address.';
      default:
        return 'Something went wrong';
    }
  }
}
