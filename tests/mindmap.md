# intershop.eu

## path-1: risikobasierte Regressionstests

- [passed] Login with valid user data (happy case)
- [failed: API HTTP error] Login with invalid soft hypen (U+00AD) 
- [passed] Checkout

## path-2: explorative Tests (Edge Case, LuP)

- [open] [Cart -> add / remove](./example.spec.ts)
- [finished with bugs] Products -> filter & sort

## path-3: Smoke Tests (critical) 

- [n/a] Checkout -> back navigation
- [blocked] [Cart -> add all products](./cart_AddAllProducts.spec.ts)
