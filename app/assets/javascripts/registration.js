$(document).ready(function(){
  $('#signup-form')
  .form({
    first_name: {
      identifier  : 'user[first_name]',
      rules: [
      {
        type   : 'empty',
        prompt : 'Please enter your name'
      },
      {
        type   : 'length[2]',
        prompt : 'name must be longer than two characters'
      }
      ]
    },
    last_name: {
      identifier  : 'user[last_name]',
      rules: [
      {
        type   : 'empty',
        prompt : 'Please enter your name'
      },
      {
        type   : 'length[2]',
        prompt : 'name must be longer than two characters'
      }
      ]
    },
    email: {
      identifier  : 'user[email]',
      rules: [
      {
        type   : 'email',
        prompt : 'Please enter a valid email'
      }
      ]
    },
    zipcode: {
      identifier  : 'user[zipcode]',
      rules: [
      {
        type   : 'integer',
        prompt : 'Please enter a zipcode'
      }
      ]
    },
    gender: {
      identifier  : 'user[gender]',
      rules: [
      {
        type   : 'empty',
        prompt : 'Please select a gender'
      }
      ]
    },

    age: {
      identifier  : 'user[age]',
      rules: [
      {
        type   : 'integer',
        prompt : 'Please enter your age'
      }
      ]
    },

    password: {
      identifier : 'user[password]',
      rules: [
      {
        type   : 'empty',
        prompt : 'Please enter a password'
      },
      {
        type   : 'length[6]',
        prompt : 'Your password must be at least 6 characters'
      }
      ]
    },
    password_confirmation: {
      identifier : 'user[password_confirmation]',
      rules: [
      {
        type   : 'match[user[password]]',
        prompt : 'Passwords do not match'
      }
      ]
    }
  }, {inline: true});
  $('#new_dog')
  .form({
    name: {
      identifier  : 'dog[name]',
      rules: [
      {
        type   : 'empty',
        prompt : 'Please enter your name'
      }
      ]
    },
    breed: {
      identifier  : 'dog[breed]',
      rules: [
      {
        type   : 'empty',
        prompt : "If you don't know you can always put mutt"
      }
      ]
    },
    gender: {
      identifier  : 'dog[gender]',
      rules: [
      {
        type   : 'empty',
        prompt : 'Please let us know what gender your dog is'
      }
      ]
    }
  }, {inline: true});
})
