package main

import (
	"database/sql"
	"log"

	"github.com/JaydenTeoh/simplebank/api"
	db "github.com/JaydenTeoh/simplebank/db/sqlc"
	"github.com/JaydenTeoh/simplebank/util"
	_ "github.com/lib/pq"
)

func main() {
	// Load configurations from environment variables from root directory
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("cannot load config:", err)
	}
	// establish connection to database
	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("cannot connect to db:", err)
	}

	store := db.NewStore(conn)
	server, err := api.NewServer(config, store)
	if err != nil {
		log.Fatal("cannot create server:", err)
	}

	if err = server.Start(config.ServerAddress); err != nil {
		log.Fatal("cannot start server", err)
	}
}
