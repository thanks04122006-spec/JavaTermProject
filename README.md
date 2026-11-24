# 쿠키공장 생산·출고 관리 시스템

JAVA기초 기말 프로젝트입니다. Java Swing에서 생산 현황을 조회하고 생산을 등록·수정할 수 있습니다. 출고 현황 확인과 출고 등록·수정·삭제도 지원합니다.

## 실행 방법

1. Java 21과 Oracle JDBC 드라이버를 준비합니다. IntelliJ 설정에는 다운로드 폴더의 ojdbc11.jar 경로가 지정되어 있습니다.
2. 로컬 Oracle XE의 C##DBSOFT 계정에서 [테이블 생성 SQL](sql/dbsoft.sql)을 실행합니다. 기존 테이블이 있는 경우 이 단계는 건너뜁니다.
3. [샘플 SQL](sql/sample_data.sql)을 한 번 실행하면 화면에서 SAMPLE-로 조회할 수 있습니다.
4. IntelliJ에서 final_project.controller.ProductionController 실행 구성의 환경 변수에 DB_PASSWORD를 지정하고 main()을 실행합니다. 연결 정보는 localhost:1521, SID는 xe입니다.

[기말 보고서](report/CookieFactoryReport.pdf)
