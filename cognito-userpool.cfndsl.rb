CloudFormation do

  tags = {}
  tags.merge!({Environment: Ref(:EnvironmentName)})
  tags.merge!({EnvironmentType: Ref(:EnvironmentType)})


  extra_tags = external_parameters.fetch(:extra_tags, [])
  extra_tags.each { |key,value| tags.merge!({ key => value }) }

  pool_name = external_parameters.fetch(:pool_name, '${EnvironmentName}')
  account_recovery_setting = external_parameters.fetch(:account_recovery_setting, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  admin_create_user_config = external_parameters.fetch(:admin_create_user_config, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  alias_attributes = external_parameters.fetch(:alias_attributes, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  auto_verified_attributes = external_parameters.fetch(:auto_verified_attributes, nil)
  device_configuration = external_parameters.fetch(:device_configuration, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  email_configuration = external_parameters.fetch(:email_configuration, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  email_verification_message = external_parameters.fetch(:email_verification_message, nil)
  email_verification_subject = external_parameters.fetch(:email_verification_subject, nil)
  enabled_mfas = external_parameters.fetch(:enabled_mfas, [])
  lambda_config = external_parameters.fetch(:lambda_config, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  mfa_configuration = external_parameters.fetch(:mfa_configuration, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  password_policy = external_parameters.fetch(:password_policy, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  schema = external_parameters.fetch(:schema, [])
  sms_authentication_message = external_parameters.fetch(:sms_authentication_message, nil)
  sms_configuration = external_parameters.fetch(:sms_configuration, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  sms_verification_message = external_parameters.fetch(:sms_verification_message, nil)
  username_attributes = external_parameters.fetch(:username_attributes, [])
  username_configuration = external_parameters.fetch(:username_configuration, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  user_pool_add_ons = external_parameters.fetch(:user_pool_add_ons, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }
  verification_message_template = external_parameters.fetch(:verification_message_template, {}).transform_keys {|k| k.split('_').collect(&:capitalize).join }

  Cognito_UserPool(:UserPool) do
    UserPoolName FnSub(pool_name)
    AccountRecoverySetting account_recovery_setting unless account_recovery_setting.empty?
    AdminCreateUserConfig   admin_create_user_config unless admin_create_user_config.empty?
    AliasAttributes alias_attributes unless alias_attributes.empty?
    AutoVerifiedAttributes auto_verified_attributes unless auto_verified_attributes.nil?
    DeviceConfiguration device_configuration unless device_configuration.empty?
    EmailConfiguration email_configuration unless email_configuration.empty?
    EmailVerificationMessage email_verification_message unless email_verification_message.nil?
    EmailVerificationSubject email_verification_subject unless email_verification_subject.nil?
    EnabledMfas enabled_mfas unless enabled_mfas.empty?
    LambdaConfig lambda_config unless lambda_config.empty?
    MfaConfiguration mfa_configuration unless mfa_configuration.empty?
    Policies({
      PasswordPolicy: password_policy
    }) unless password_policy.empty?
    Schema schema unless schema.empty?
    SmsAuthenticationMessage sms_authentication_message unless sms_authentication_message.nil?
    SmsConfiguration sms_configuration unless sms_configuration.empty?
    SmsVerificationMessage  sms_verification_message unless sms_verification_message.nil?
    UsernameAttributes username_attributes unless username_attributes.empty?
    UsernameConfiguration username_configuration unless username_configuration.empty?
    UserPoolAddOns user_pool_add_ons unless user_pool_add_ons.empty?
    UserPoolTags tags
    VerificationMessageTemplate verification_message_template unless verification_message_template.empty?
  end

  Output(:UserPoolId) {
    Value Ref(:UserPool)
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-UserPoolId")
  }
  Output(:UserPoolArn) {
    Value FnGetAtt(:UserPool,'Arn')
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-UserPoolArn")
  }
  Output(:UserPoolProviderName) {
    Value FnGetAtt(:UserPool,'ProviderName')
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-UserPoolProviderName")
  }
  Output(:UserPoolProviderURL) {
    Value FnGetAtt(:UserPool,'ProviderURL')
    Export FnSub("${EnvironmentName}-#{external_parameters[:component_name]}-UserPoolProviderURL")
  }

end