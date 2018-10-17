import { test } from 'qunit';
import moduleForAcceptance from 'ember-site/tests/helpers/module-for-acceptance';

moduleForAcceptance('Acceptance | list rentals');

test('should show rentals as the home page', function(assert) {
  visit('/');

  andThen(function() {
    assert.equal(currentURL(), '/rentals', 'should redirect automatically');    
  });
});

test('Click link to contact information', function(assert) {
  visit('/');
  click('a:contains("About")');
  andThen(function() {
    assert.equal(currentURL(), '/about', 'should redirect automatically');    
  });
});

test('The count of items in list should be 3', function(assert) {
  visit('/');
  andThen(function() {
    assert.equal(find('.listing').length, 3, 'should see 3 listings');
  });
});
