postgres:
	docker run --name postgres15 --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=simplebank -d postgres:15-alpine

createdb:
	docker exec -it postgres15 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres15 dropdb simple_bank

migrateup1:
	migrate -path db/migration -database "postgresql://root:simplebank@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migrateup:
	migrate -path db/migration -database "postgresql://root:simplebank@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown1:
	migrate -path db/migration -database "postgresql://root:simplebank@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

migratedown:
	migrate -path db/migration -database "postgresql://root:simplebank@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/JaydenTeoh/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 sqlc test server mock