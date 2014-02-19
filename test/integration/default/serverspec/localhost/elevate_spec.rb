require 'spec_helper'

describe "elevate resource with sudo provider" do
  after(:all) do
    File.unlink("/tmp/as_root") if File.exists?("/tmp/as_root")
    File.unlink("/tmp/as_nobody") if File.exists?("/tmp/as_nobody")
  end

  context "to root" do
    describe file('/tmp/as_root') do
      it { should be_file }
      its(:content) { should match(/^as_root$/) }
      it { should be_owned_by('root') }
    end
  end

  context "to nobody" do
    describe file('/tmp/as_nobody') do
      it { should be_file }
      its(:content) { should match(/^as_nobody$/) }
      it { should be_owned_by('nobody') }
    end
  end

  context "with group nobody" do
    describe file('/tmp/as_group_nobody') do
      it { should be_file }
      its(:content) { should match(/^as_group_nobody$/) }
      it { should be_grouped_into('nobody') }
    end
  end

  context "with environment variables" do
    describe file('/tmp/with_env') do
      it { should be_file }
      its(:content) { should match(/^COW$/) }
    end

  end
end
