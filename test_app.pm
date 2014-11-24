#!/usr/bin/env perl
use Mojolicious::Lite;

get '/' => sub {
  my $self = shift;

  open my $fh, '<', "public/hello.txt";
  my $file_content = <$fh>;
  close $fh;

  my $russian_text_in_var = 'При этом текст из переменной нормально виден';

  $self->stash(file_content => $file_content, rus_text => $russian_text_in_var);
  print "Everything is ok in console mode: $file_content\n"; # в консоли видно что файл считался нормально
  $self->render('index');
};

app->start;
__DATA__

@@ index.html.ep
<!DOCTYPE html>
<html>
  <head>
  	<title>Encoding problem</title>
  </head>
  <body>Вот содержимое файла:
    <br>
	<%= $file_content %>
	<br><br>
	<%= $rus_text %>
  </body>
</html>
