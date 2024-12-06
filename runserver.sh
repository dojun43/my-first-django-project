#!/bin/bash
date > current_time.txt

# 해당 디렉터리가 있으면
if [ -d $HOME/my-first-django-project ]; then
  # git pull
  cd my-first-django-project
  git pull origin main
else # 없으면
  # git repository로부터 파일을 clone
  git clone https://github.com/dojun43/my-first-django-project.git
  cd my-first-django-project
fi

# python3.12-venv 없으면 설치
if dpkg -l | grep -q "python3.12-venv"; then
        echo "python3.12-venv is already installed."
else
        sudo apt update
        sudo apt install -y python3.12-venv
        echo "python3.12-venv is installed."
fi

# 가상 환경 설정
rm -rf .venv # 기존에 설치한 가상 환경 있으면 있으면 삭제
python3 -m venv .venv
source .venv/bin/activate

# 종속성 설치
chmod +x runserver.sh
pip3 install -r requirements.txt

# 종속성 설치 확인
pip3 freeze

# 서버가 실행중이면 끄기
export SERVER_PID=$(ps -ef | grep runserver | awk '{ print $2 }' | head -1)
echo "Server PID는 $SERVER_PID 번입니다. 해당 프로세스를 죽입니다..."
kill -15 $SERVER_PID

# 백그라운드로 서버 실행
DEBUG=True nohup python3 manage.py runserver 0.0.0.0:8000 > server.log 2>&1 &