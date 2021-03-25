CfhighlanderTemplate do

  Description "#{component_name} - #{component_version} - (#{template_name}@#{template_version})"
  Name 'cognito-userpool'

  Parameters do
    ComponentParam 'EnvironmentName', 'dev', isGlobal: true
    ComponentParam 'EnvironmentType', 'development', isGlobal: true
  end
    
end
