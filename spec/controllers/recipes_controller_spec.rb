require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  render_views
  describe "index" do
    before do
      create(:recipe, name: 'Baked Potato w/ Cheese')
      create(:recipe, name: 'Garlic Mashed Potatoes')
      create(:recipe, name: 'Potatoes Au Gratin')
      create(:recipe, name: 'Baked Brussel Sprouts')

      xhr :get, :index, format: :json, keywords: keywords
    end

    subject(:results) { JSON.parse(response.body)}

    def extract_name
      ->(object) { object["name"] }
    end

    context "when the search finds results" do
      let(:keywords) { 'baked' }
      it 'should 200' do
        expect(response.status).to eq(200)
      end
      it 'should return two results' do
        expect(results.size).to eq(2)
      end
      it "should include 'Baked Potato w/ Cheese'" do
        expect(results.map(&extract_name)).to include('Baked Potato w/ Cheese')
      end
      it "should include 'Baked Brussel Sprouts'" do
        expect(results.map(&extract_name)).to include('Baked Brussel Sprouts')
      end
    end

    context 'when there are no search parameters' do
      it 'returns all the recipes' do
        expect(results.size).to eq(4)
      end
    end

    context "when the search doesn't find results" do
      let(:keywords) { 'foo' }
      it 'should return no results' do
        expect(results.size).to eq(0)
      end
    end

  end

end
