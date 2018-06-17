<%@ LANGUAGE = PerlScript %>
<%
$requestMethod = $Request->ServerVariables('REQUEST_METHOD')->Item;
return if $requestMethod ne 'POST';

$fname			= &f_getClientVariable('fname', 'Not Provided');
$lname			= &f_getClientVariable('lname', 'Not Provided');
$hcn			= &f_getClientVariable('hcn', 'Not Provided');
$address		= &f_getClientVariable('address', 'Not Provided');
$city           = &f_getClientVariable('city','Not Provided');
$state			= &f_getClientVariable('state','Not Provided');
$zip		    = &f_getClientVariable('zip','Not Provided');
$country		= &f_getClientVariable('country','Not Provided');
$specialty		= &f_getClientVariable('specialty','Not Provided');
$sp				= &f_getClientVariable('sp','Not Provide');
$phone1			= &f_getClientVariable('phone1','Not Provided');
$phone2			= &f_getClientVariable('phone2','Not Provided');
$phone3			= &f_getClientVariable('phone3','Not Provided');
$ph				= &f_getClientVariable('ph','Not Provided');
$fax			= &f_getClientVariable('fax','Not Provided');
$email			= &f_getClientVariable('email','Not Provided');
$website		= &f_getClientVariable('website','Not Provided');
$notes			= &f_getClientVariable('notes','Not Provided');

&f_send();
$thanks = <<TX1;
<img src="images/t_online.gif" align=right><br><br>
<p> <font color=#FF0000 face=arial size=2> Your registration details have been sent successfully. We will come back to you as soon as possible.<br>
Thank you.</font>

TX1
$title        = "Unanidoctors - Registration sent Successfully" ;
$content = &f_readFile($Server->MapPath("template.html"));
$content =~ s/<!--REPLACE.BODY-->/$thanks/;
$content =~ s/<!--REPLACE.TITLE-->/$title/;
$Response->write($content);

sub f_send {
   my $body = <<BODY11;
The following message is received from your website: http://unanidoctors.com/
<br>First Name: $fname <br>
Last Name: $lname <br>
Health Center: $hcn <br>
Address: $address <br>
City : $city <br>
State : $state <br>
ZIP: $zip <br>
Country : $country <br>
Specialty : $specialty <br>
Services Provided : $sp <br>
US Phone : $phone1 $phone2 $phone3 <br>
Non US Phone : $ph <br>
Fax : $fax <br>
eMail : $email <br>
Website : $website <br>
Notes : $notes <br>
### end of message ###

BODY11
# drasad\@unanidoctors.com
&f_sendEmail( "Website Visitor", "mayor\@HamaraShehar.com", "drasad\@unanidoctors.com", "Message from your website visitor - Registration Form", $body );
#$Response->write($body);
}

sub f_readFile {
  local( $fileName ) = shift;
  local( $tempContent );
  open( FL2, "<$fileName" );
  @tempContent  = <FL2>;
  close( FL2 );
  return ( join( '', @tempContent ) );
}

sub f_getClientVariable	 {
   my $var1     = shift;
   my $default1 = shift;
   my $temp1    = '';

   if ( $var1 eq null ) {
	  return 'null';
   }
   if ( defined($Request->Form($var1)->Item) ) {
      $temp1 = $Request->Form($var1)->Item;
   }
   if ( $temp1 ne '' ) {
      return $temp1;
   }
   elsif ( defined($default1)) {
   	  return $default1;
   }
   return 'null';
}	##f_getClientVariable

sub f_sendEmail1 {
   my $fromWhom  = shift;
   my $fromEmail = shift;
   my $toEmail   = shift;
   my $subject   = shift;
   my $body      = shift;

   my $Mailer = $Server->CreateObject("SMTPsvg.Mailer");
   $fromWhom  = 'From HamaraShehar' if ($fromWhom eq '');
   $fromEmail = 'mayor@hamarashehar.com' if ($fromEmail eq '');

$objMail = $Server->CreateObject("CDONTS.Newmail");
$objMail->{'To'} = $toEmail;
$objMail->{'Subject'} = $subject;
$objMail->{'From'} = $fromEmail;
$objMail->{'Body'} = $body;
$rc = $objMail->send();
undef $objMail;
return 1;
}


sub f_sendEmail {
   my $fromWhom  = shift;
   my $fromEmail = shift;
   my $toEmail   = shift;
   my $subject   = shift;
   my $body      = shift;
   $fromWhom  = 'From HamaraShehar' if ($fromWhom eq '');
   $fromEmail = 'mayor@hamarashehar.com' if ($fromEmail eq '');
    use Mail::Sender;
my $sender = new Mail::Sender {from => $fromEmail,smtp => 'm15.hs9.in',
'auth' => 'PLAIN', authid => 'do.not.reply@HamaraShehar.com',authpwd =>
'D0.N0t.Reply'};
$sender->OpenMultipart({to=> $toEmail, subject=> $subject});
$sender->Body();
$sender->Send($body);
$sender->Close();
return 1;
   $objMail = $Server->CreateObject("CDO.Message");
   $objMail->{'To'} = $toEmail;
   $objMail->{'Subject'} = $subject;
   $objMail->{'From'} = $fromEmail;
   $objMail->{'TextBody'} = $body;
   $rc = $objMail->send();
   undef $objMail;
   return 1;
}
%>
