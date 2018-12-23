<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>
file
</title>
</head>
<body>
<?php
function upOne($upfile){
  $tmpf=$_FILES[$upfile]["tmp_name"];
  if(is_uploaded_file($tmpf)){
    echo "<br/>\n[";
    echo $_FILES[$upfile]["name"];
    echo " (size: ".filesize($tmpf).")]<br/>\n"; 
    $fp=fopen($tmpf,'r');
    echo htmlspecialchars(fread($fp,filesize($tmpf)));
    # cf. htmlspecialchars_decode();
    # cf. strip_tags();
    # cf. nl2bra(); 改行直前に"<br />"
  }
  else {
    echo "ファイルを選択してください";
  }
}
upOne("upfile");
upOne("upfile2");
?>
</body>
</html>


