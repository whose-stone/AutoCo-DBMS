# E-R Diagram - Automobile Company Database

See the full ER diagram documentation in the repository.

## Entities: Company, Brand, Model, Vehicle, Customer, Dealer, Supplier, Plant, Part, Vehicle_Option

## Key Relationships
- Company 1:N Brand
- Brand 1:N Model
- Model N:1 Vehicle
- Dealer M:N Brand (junction: dealer_brand)
- Supplier M:N Part (junction: supplier_part with plant_location)
- Model M:N Part (junction: model_part)
- Dealer 1:N Inventory 1:1 Vehicle
- Sale links Vehicle, Customer, Dealer

## Design: BCNF normalized, VIN as natural PK for Vehicle
