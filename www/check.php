<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
hello!
</title>
</head>
<body>
<?php
print 'ようこそ';
$updata=$_POST['nickname'];
$dsn='mysql:dbname=test_mydb;host=localhost';
$user='user';
$pass='****';
$dbh=new PDO($dsn,$user,$pass);
$dbh->query('SET NAMES utf8');
$sql='select * from tbl';
$stmt=$dbh->prepare($sql);
$stmt->execute();
print 'ようこそ.';

while(1)
{
  $rec=$stmt->fetch(PDO::FETCH_ASSOC);
  if($rec==false)
  {
    break;
  }
  print $rec['name'];
  print $rec['age'];
  print '<br />';
}
$sql='insert into tbl (name, age) values(?, ?)';
$stmt=$dbh->prepare($sql);
$data=array($updata,22);
$stmt->execute($data);
$dbh=null;
?>
</body>
</html>


