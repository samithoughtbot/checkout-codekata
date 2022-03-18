```mermaid
sequenceDiagram
    note over Checkout: for each item
    Checkout->>+Item: what is your price? <br>(has_a_reduction)
    activate Item
    Item->>+Checkout: a number
    deactivate Item
```