$(document).ready(function(){
  $('.content.info').on('click', function(){
    var div = $(this).find('#more-info');
    var span = $(this).find('span');
    div.fadeIn().toggleClass('inactive');
    if(div.hasClass('inactive')){
      span.text('more');
      div.fadeOut().addClass('inactive');
    }else{
      span.text('less');
      }
  });

  $('.card.pop-out').on('click', function(){
    var dogId = $(this).find('.content.dog').data('dog-id');
    var imagePath = $(this).find('img')[0].src;
    var url = '/dogs/' + dogId;
    $.ajax(url, {type: 'get'}).done(function(data){
      var source = $('#dog-modal').html();
      var template = Handlebars.compile(source);

      var context = {
        name: data.name,
        image: imagePath,
        bio: data.bio,
        breed: data.breed,
        gender: data.gender,
        play: data.play,
        personality: data.personality
        }

        var html = template(context);

      $('body').append(html);
      $('.ui.modal')
      .modal('show')
    });
  });
})
