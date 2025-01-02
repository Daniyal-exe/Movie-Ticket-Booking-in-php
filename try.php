<?php
include "./db.php";
include "./authenticate.php";

if(!$user){
    echo " ";
}else{
    echo  $user['id'];

}
?>