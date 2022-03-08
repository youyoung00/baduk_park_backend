<?php
// defined 는 제어권을 프레임워크가 가져가기 위한 코드. 대부분의 파일에 적용됨.
defined('BASEPATH') OR exit('No direct script access allowed'); 

class Board extends CI_Controller {

	public function index()
	{
		echo "회원 프로그램";
	}

	public function input()
	{
		echo "회원 가입";
	}

	public function login()
	{
		echo "로그인";
	}

	public function update()
	{
		echo "회원 정보 수정";
	}
}
