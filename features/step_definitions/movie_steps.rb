# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
      # each returned element will be a hash whose key is the table header.
      # you should arrange to add that movie to the database here.
    Movie.create(:title => movie[:title], :rating => movie[:rating], :director => movie[:director], :description => movie[:description], :release_date => movie[:release_date])
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  # still at 99 problems since we didn't use a regex for this
  page.body.index(e1).should < page.body.index(e2)
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split.each do |rating|
    rating.gsub!(/,/, '')
    if uncheck.to_s == ''
      step %Q{I check "ratings[#{rating}]"}
    else
      step %Q{I uncheck "ratings[#{rating}]"}
    end
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |title, director|
  Movie.where("title = ?", title).select("director")[0][:director].should == director
end
