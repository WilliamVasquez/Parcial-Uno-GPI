var inP = $('.input-field');

inP.on('blur', function () {
	if (!this.value) {
		$(this).parent('.f_row').removeClass('focus');
	} else {
		$(this).parent('.f_row').addClass('focus');
	}
}).on('focus', function () {
	$(this).parent('.f_row').addClass('focus');
	$('.btn').removeClass('active');
	$('.f_row').removeClass('shake');
});

$('.resetTag').click(function (e) {
	e.preventDefault();
	$('.formBox').addClass('level-forget').removeClass('level-reg');
});

$('.back').click(function (e) {
	e.preventDefault();
	$('.formBox').removeClass('level-forget').addClass('level-login');
});

$('.regTag').click(function (e) {
	e.preventDefault();
	$('.formBox').removeClass('level-reg-revers');
	$('.formBox').toggleClass('level-login').toggleClass('level-reg');
	if (!$('.formBox').hasClass('level-reg')) {
		$('.formBox').addClass('level-reg-revers');
	}
});
$('.btnn').each(function () {
	$(this).on('click', function (e) {

		var finp = $(this).parent('form').find('input');

		if (!finp.val() == 0) {
			$(this).addClass('active');
		}

		setTimeout(function () {
			inP.val('');

			$('.f_row').removeClass('shake focus');
			$('.btn').removeClass('active');
		}, 2000);

		if (inP.val() == 0) {
			inP.parent('.f_row').addClass('shake');
		}
	});
});
$("#passUser").keypress(function (e) {
	if (e.which == 13)
		$('#login').trigger('click');
});

$(function () {
	function redirect() {
		window.location.href = '/';
	}
	$('#login').click(function (e) {
		let form = $(this).closest("form");
		if (form.valid() === true) {
			$.ajax({
				url: '../Home/ValidUser',
				type: 'post',
				data: $("form").serialize()
			}).done(function (response) {
				if (response.indexOf("Bienvenido ") > -1) {
					mostrarAlerta('success', response);
					setTimeout(redirect, 3001);
				}
				else if (response.length == 2)
					mostrarAlerta('error', 'Credenciales Incorrectas');
				else
					mostrarAlerta('error', response);
			}).fail(function () {
				mostrarAlerta('error', 'Se murio.')
			});
		}
		else
			mostrarAlerta('info', 'Campos requeridos');
	});
});