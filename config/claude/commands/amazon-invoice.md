# /amazon-invoice

## Description

Processes Amazon invoice PDFs and creates bank transactions in Xero for
reconciliation. Handles single/multi-page invoices with proper VAT treatment
and line item breakdown.

## Functionality

1. **Reads PDF invoice(s)** - Extracts order details, line items, VAT rates, and amounts
2. **Handles multi-page invoices** - Combines multiple vendors/invoices from same order into single transaction
3. **Creates Xero bank transaction** with:
   - **Bank**: Monzo Business Account (default)
   - **Contact**: Amazon (auto-selected)
   - **Line items**: Proper categorization and VAT treatment
   - **Perfect reconciliation**: Total matches bank statement exactly

## VAT Handling Rules

- **Standard 20% VAT**: Use VAT-inclusive amounts + INPUT2 tax type
- **Reverse Charge (0%)**: Use REVERSECHARGES tax type
- **Free shipping**: £0.00 items excluded from line items

## Account Code Mapping

- **Products**: 473 (Repairs & Maintenance)
- **Shipping**: 425 (Postage, Freight & Courier)

## Output

- **Transaction ID** and Xero deep link
- **Total amount** for bank reconciliation verification
- **Success confirmation** with proper VAT treatment applied

## Special Cases Handled

- Multi-vendor orders (combines into single transaction)
- Multiple shipping charges (separate line items)
- Reverse charge VAT from EU suppliers
- Zero-value shipping (excluded automatically)

## Template

Uses VAT-inclusive amounts from invoice "Unit price (incl. VAT)" column with appropriate tax types for automatic VAT
 calculation and proper bank reconciliation totals.
