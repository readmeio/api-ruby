require 'spec_helper'

describe Build do
  before(:each) do
    @api_key = 'abdul_f9cfcade4264cba870585a'
  end
  it 'has a version number' do
    expect(Build::VERSION).not_to be nil
  end

  it "should call api successfully" do
    api = Build::Api.new
    api.config(@api_key)
    response = api.run('math','multiply',{:numbers => [10,20,30]})
    expect(response.to_i).to eq(6000)
  end

  it "should call api method successfully" do
    api = Build::Api.new
    api.config(@api_key)
    response = api.run('temp-deprecated','sayHello',{:name => "Greg"})
    expect(response.include?('Greg')).to eq(true)
  end

  it "should call api with error due to wrong method" do
    api = Build::Api.new
    api.config(@api_key)
    response = api.run('math','multiply1',{:numbers => [10,20,30]})
    expect(response.class).to eq(Hash)
    expect(response.key?("error")).to eq(true)
  end

  it "should call api with error due to wrong service" do
    api = Build::Api.new
    api.config(@api_key)
    response = api.run('wrong','multiply',{:numbers => [10,20,30]})
    expect(response.class).to eq(Hash)
    expect(response.key?("error")).to eq(true)
  end
end
