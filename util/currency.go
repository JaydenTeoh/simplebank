package util

// Constants for all supported currencies
const (
	USD = "USD"
	EUR = "EUR"
	SGD = "SGD"
	HKD = "HKD"
	RMB = "RMB"
	GBP = "GBP"
)

func IsSupportedCurrency(currency string) bool {
	switch currency {
	case EUR, USD, SGD, HKD, RMB, GBP:
		return true
	}
	return false
}
