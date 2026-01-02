# /uber-eats-invoice

## Description

Processes Uber Eats invoice PDFs and creates bank transactions in Xero for
reconciliation. Handles the dual-invoice structure (restaurant + delivery) with
proper VAT treatment and line item breakdown.

## Functionality

1. **Reads PDF invoice(s)** - Extracts order details, restaurant charges, delivery fees, and VAT
2. **Handles dual invoices** - Uber Eats orders have two invoices:
   - **Restaurant invoice**: Food items from the restaurant
   - **Delivery invoice**: Uber's delivery/service fees
3. **Creates Xero bank transaction** with:
   - **Bank**: Monzo Business Account (default)
   - **Contact**: Uber (auto-selected)
   - **Line items**: Separate entries for food and delivery
   - **Perfect reconciliation**: Total matches bank statement exactly

## VAT Handling Rules

- **Restaurant food**: Use VAT-inclusive amounts + INPUT2 tax type (20% VAT)
- **Delivery fees**: Use VAT-inclusive amounts + INPUT2 tax type (20% VAT)
- **Service fees**: Use VAT-inclusive amounts + INPUT2 tax type (20% VAT)
- **Tips**: NO_TAX (tips are not VAT-able)

## Account Code Mapping

- **Food/Restaurant items**: 311 (Food)
- **Service fees**: 311 (Food)
- **Delivery fees**: 425 (Postage, Freight & Courier)
- **Tips**: 311 (Food)

## Output

- **Transaction ID** and Xero deep link
- **Total amount** for bank reconciliation verification
- **Success confirmation** with proper VAT treatment applied

## Special Cases Handled

- Combined restaurant + delivery invoices (separate line items)
- Multiple items from same restaurant
- Service fees and small order fees
- Driver tips (excluded from VAT)
- Promotional discounts

## Template

Uses VAT-inclusive amounts from invoices with appropriate tax types for automatic VAT
calculation and proper bank reconciliation totals.
