package controllers

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	ledgerContext "github.com/RealImage/QLedger/context"
	"github.com/RealImage/QLedger/models"
)

func GetAccountInfo(w http.ResponseWriter, r *http.Request, context *ledgerContext.AppContext) {
	accountsDB := models.AccountDB{DB: context.DB}

	id := r.FormValue("id")
	account := accountsDB.GetByID(id)
	data, err := json.Marshal(account)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Fprint(w, string(data))
}