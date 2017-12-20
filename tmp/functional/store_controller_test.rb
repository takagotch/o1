
test "store.js" do
	get :index
	assert_select '.store .entry > img', 3
	assert_select '.entry input[type=submit]', 3
end
