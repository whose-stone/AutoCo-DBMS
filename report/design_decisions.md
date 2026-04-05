# Design Decisions & Coding Challenges

See the full design decisions document in the downloaded project files.

## Key Decisions
1. VIN as natural primary key for Vehicle
2. Company -> Brand -> Model hierarchy (1:N:N)
3. dealer_inventory as separate table for date tracking
4. supplier_part includes plant_location for recall queries
5. M:N junction table for dealer-brand relationship

## Key Challenges
1. Single-page app without server (solved with in-memory JS data store)
2. Multi-dimensional aggregation in JS (hash map approach)
3. Dynamic filter interaction (jQuery event binding)
4. Data consistency on sale (simulated transactions)
