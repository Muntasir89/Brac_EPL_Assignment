class ApiUrls {
  // EKYC
  static const String signUpApi = "api/v1/user/signup/proceed";
  static const String verifyOtpApi = "api/v1/user/signup/verify/tfa";
  static const String termsConditionsApi =
      "api/v1/meta/terms-and-conditions/103B";
  static const String setPinApi = "api/v1/user/signup/user";

  static const String checkUserTypeApi = "user_type";
  static const String checkBalanceApi = "wallet/check-balance";
  static const String feeChargeApi = "fee_charge";
  static const String appForceUpdateWithConfig = "api/v1/meta/config/get";
  static const String resetPinApi = "api/v1/user/user/pcr/reset/pin";
  static const String dropdownsApi = "api/v1/meta/all/dropdowns/location-data";
  static const String paperKycFileApi =
      "api/v1/file-server/public/common/kyc/file/upload";
  static const String nidOcrApi = "api/v1/user/e-kyc/ocr";
  static const String paperKycInfoApi = "api/v1/user/paper-kyc/self";
  static const String ekycFinalSubmitApi = "api/v1/user/e-kyc/validate-user";

  // Login Api
  static const String loginApi = 'api/v1/user/user/token';
  static const String myQrApi = 'api/v1/user/qr-code/public/';
  static const String sendOtpApi = 'api/v1/user/send/otp/registered/user';
  static const String deviceBindingApi = 'api/v1/user/device/binding';
  static const String tfaApi = 'api/v1/user/users/features';

  // Send Money
  static const String sendMoneyRecentListApi =
      'api/v1/send-money/contacts/recent/list';
  static const String sendMoneyUserInfo = 'api/v1/send-money/account/info/';
  static const String sendMoneyTfa = 'api/v1/send-money/tfa/users/features/';
  static const String logoutApi = 'api/v1/user/user/logout';
  static const String sendMoneyApi = 'api/v1/send-money';
  static const String requestMoneyApi = 'api/v1/send-money/request-money';
  static const String chargeAndFeeApi =
      'api/v1/charge-and-fee/multi-wallet/charge/calculation';
  static const String childListApi = 'api/v1/user/get-user-child-details';
  static const String parentListApi = 'api/v1/user/details/accounts/';
  static const String accountBalance = 'api/v1/user/accounts/balance/details';
  static const String childAccountBalance = 'api/v1/user/child/';

  //Request Money
  static const String requestMoneyTfa = 'api/v1/send-money/tfa/users/features/';
  static const String requestMoneyUserInfo = 'api/v1/send-money/account/info/';
  static const String monthRequestMoneyApi =
      'api/v1/send-money/request-money/history';
  static const String requestMoneyHistoryApi =
      'api/v1/send-money/request-money/history';

  // Dashboard
  static const String featureListApi =
      'api/v1/charge-and-fee/transaction-feature/list';
  static const String changePasswordApi = 'api/v1/user/transaction/pin/update';
  static const String transactionCategoryApi =
      'api/v1/user/transaction-feature/filter-list';
  static const String startApi = 'api/v1/user/signup/proceed';
  static const String qrDetails = 'api/v1/user/parse-qr-code';
  static const String banglaQrDetails = 'api/v1/user/bangla-qr/parse';
  static const String qrScanApi = 'api/v1/user/bangla-qr/parse';

  // Recharge
  static const String rechargeRecentListApi =
      'api/v1/payment/mobile-recharge/contact-info/list';
  static const String rechargeSuggestedAmountApi =
      'api/v1/payment/top-up/offer/suggested-amount';
  static const String rechargeOfferApi = 'api/v1/payment/top-up/offer';
  static const String limitVerifyApi =
      'api/v1/charge-and-fee/transaction-usage/limit/verify';
  static const String rechargeChargeApi =
      'api/v1/charge-and-fee/config/fee/calculation';
  static String rechargeInitiateApi =
      'api/v1/payment/mobile-recharge/do-mobile-recharge';
  static String operatorListApi =
      'api/v1/payment/mobile-recharge/get-operators-data';

  static const String personalQr = 'api/v1/user/qr-code-emvco/';
  static const String banglaQr = 'api/v1/user/bangla-qr/generate/';
  static const String dynamicQr = 'api/v1/user/bangla-qr/dynamic/generate';

  static const String limitAndUsageMonthlyApi =
      'api/v1/charge-and-fee/transaction-usage/limit/monthly';
  static const String limitAndUsageDailyApi =
      'api/v1/charge-and-fee/transaction-usage/limit/daily';
  static const String monthStatementApi =
      'api/v1/user/transaction-history/paginated';

  static const String headerWithBundleApi =
      'api/v1/payment/top-up/offer/head-title/with-bundle';

  static const String similarBundleOfferApi =
      'api/v1/payment/top-up/offer/{operatorType}/{amount}';

  // multi wallet
  static String multiWalletListApi = 'api/v1/multi-wallet/wallet/get-balance';

  // e money
  static String bankListApi = 'api/v1/meta/e-money/bank/list';
  static String featureCodeApi =
      'api/v1/charge-and-fee/transaction-feature/featureCode';
  static String commonFileUploadApi =
      'api/v1/file-server/public/common/file/upload';
  static String eMoneySubmitApi = 'api/v1/send-money/e-money/request/create';
  static String eMoneyHistoryApi = 'api/v1/send-money/e-money/request/list/all';
  static String bannerListApi = 'api/v1/meta/slider-banner/list';
  static String downloadPdfApi = 'api/v1/user/transaction-history/statement';
  static String transactionHistoryShareApi =
      'api/v1/user/transaction-history/share';
  static String setBiometricApi = 'api/v1/user/enabling/biometric/login';
  static String biometricLoginApi = "api/v1/user/biometric/authentication";

  static String agentLocationApi = 'api/v1/user/agent-locations/nearby-agents';
  static String updateLocationApi = 'api/v1/user/agent-locations/create';
  static String requestMoneyRejectApi =
      'api/v1/send-money/request-money/reject';
  static String requestMoneyAcceptApi =
      'api/v1/send-money/request-money/accept';

  // payout

  static String cashOutHistoryApi =
      'api/v1/send-money/e-money/request/list/payout-all';
  static String distributorInfoApi = 'api/v1/user/details/account/bank';
  static String distributorBankListApi = 'api/v1/meta/bank/list';
  static String distributorBranchListApi = 'api/v1/meta/branches/list';
  static String cashOutSubmitApi =
      'api/v1/send-money/e-money/request/payout-create';

  // Push Notification
  static String pushNotificationHistoryApi =
      "api/v1/notification/push-notification/history";

  // dispute management
  static String disputeListApi = 'api/v1/user/complains/list';
  static String disputeCreateApi = 'api/v1/user/complains/create';

  static const String complainTypesApi = 'api/v1/user/complains/category';
  // Feedback
  static String improveListApi = 'api/v1/user/improvement/areas';
  static String feedbackSubmitApi = 'api/v1/user/feedback/submit';

  // STR/SAR
  static String strSarCreateApi = 'api/v1/user/str-sar/create';
  static String strSarListApi = 'api/v1/user/str-sar/list';
  static String strSarRiskLevelsApi = 'api/v1/user/str-sar/risk-levels';

  // add money and linked device
  static String accountSubmitApi = 'api/v1/transfer-money/linked-bank/request';
  static String accountListApi = 'api/v1/transfer-money/linked-bank/all/';
  static String bankLinkStatusApi = 'api/v1/transfer-money/linked-bank/status';
  static String bankDLinkStatusApi =
      'api/v1/transfer-money/unlinked-bank/status';
  static String allBankListApi = 'api/v1/transfer-money/bank/all/103';
  // static String dLinkAccountApi = 'api/v1/transfer-money/linked-bank/delete';
  static String dLinkAccountApi = 'api/v1/transfer-money/unlinked-bank/request';
  static String chargeRequestApi =
      'api/v1/charge-and-fee/config/fee/calculation';
  static String addMoneyApi = 'api/v1/transfer-money/add-money/request';
  static String transferMoneyResultApi = 'api/v1/transfer-money/txn-details';

  // CustomerToBank
  static String customerToBankApi = "api/v1/transfer-money/send-money/request";

  static String updateProfileApi = "api/v1/user/profile";

  // Pay Bill
  static String billCategoryApi = "api/v1/payment/bill-category/list";
  static String billAccountDetailsApi = "api/v1/payment/bill/input/field/info";
  static String billAccountDetailsSubmitApi =
      "api/v1/payment/bill/input/field/info-check";
  static String billPaymentApi = "api/v1/payment/bill/make-bill-payment";
}
