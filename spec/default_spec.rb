require 'yaml'

describe 'compiled component' do
  
  context 'cftest' do
    it 'compiles test' do
      expect(system("cfhighlander cftest #{@validate} --tests tests/default.test.yaml")).to be_truthy
    end      
  end
  
  let(:template) { YAML.load_file("#{File.dirname(__FILE__)}/../out/tests/default/cognito-userpool.compiled.yaml") }

  context 'Resource UserPool' do
    let(:properties) { template["Resources"]["UserPool"]["Properties"] }

    it 'has property UserPoolName ' do
      expect(properties["UserPoolName"]).to eq({"Fn::Sub"=>"${EnvironmentName}"})
    end

    it 'has default tags ' do
      expect(properties["UserPoolTags"]).to eq({
        "Environment"=> {"Ref" => "EnvironmentName"},
        "EnvironmentType"=> {"Ref" => "EnvironmentType"}
      })
    end
  end
end