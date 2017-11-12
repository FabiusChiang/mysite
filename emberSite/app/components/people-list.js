import Component from '@ember/component';

export default Component.extend({
    actions: {
        getDetails(person) {
            alert(person);
        }
    }
});
