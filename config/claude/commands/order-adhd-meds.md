Your job is to submit a form to order adhd meds.

you do this by using the playwright mcp server.

ask for sdp, dbp, pulse, weight, height from user (provided weight is kg, but for height convert feet/inches to cm.)

- Vist this page https://beyondclinics.formstack.com/forms/prescription_request_form

- select it should be dlelivered to chosen address.
for each required detail, get from onepassword using onepassword cli command and fill in: `op  read""op://Private/il7mj77fu5imjsnw3vjcknnium/Identification/${REF}"`
    - first name, REF=`first name`
    - last name, REF=last name
    - email, REF=Address/email
    - date of birt,h REF=birth date
    - address REF=Address/address
- fill in sdp, dbp, pulse, weight
- for date of physical obvs, get current day and then fill in
- For medication:  Medication methylphenidate 20mg tablets

ask user if all look right. if yes, submit form.
