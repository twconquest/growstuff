require 'rails_helper'

describe ApplicationHelper do
  it "formats prices" do
    price_in_dollars(999).should eq '9.99'
    price_with_currency(999).should eq '9.99 %s' % Growstuff::Application.config.currency
  end

  it "parses dates" do
    parse_date(nil).should eq nil
    parse_date('').should eq nil
    parse_date('2012-05-12').should eq Date.new(2012, 5, 12)
    parse_date('may 12th 2012').should eq Date.new(2012, 5, 12)
  end

  it "shows required field marker help text with proper formatting" do
    output = required_field_help_text
    expect(output).to have_selector '.margin-bottom'
    expect(output).to have_selector '.red', text: '*'
    expect(output).to have_selector 'em', text: 'denotes a required field'
  end

  describe '#avatar_uri' do
    context 'with a normal user' do
      before :each do
        @member = FactoryGirl.build(:member, email: 'example@example.com', preferred_avatar_uri: nil)
      end
      it 'should render a gravatar uri' do
        expect(avatar_uri(@member)).to eq 'http://www.gravatar.com/avatar/23463b99b62a72f26ed677cc556c44e8?size=150&default=identicon'
      end

      it 'should render a gravatar uri for a given size' do
        expect(avatar_uri(@member, 456)).to eq 'http://www.gravatar.com/avatar/23463b99b62a72f26ed677cc556c44e8?size=456&default=identicon'
      end
    end

    context 'with a user who specified a preferred avatar uri' do
      before :each do
        @member = FactoryGirl.build(:member, email: 'example@example.com', preferred_avatar_uri: 'http://media.catmoji.com/post/ujg/cat-in-hat.jpg')
      end
      it 'should render a the specified uri' do
        expect(avatar_uri(@member)).to eq 'http://media.catmoji.com/post/ujg/cat-in-hat.jpg'
      end
    end
  end
end
