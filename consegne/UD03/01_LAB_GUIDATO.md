# percorsi user e group
https://entra.microsoft.com/#view/Microsoft_AAD_UsersAndTenants/UserManagementMenuBlade/~/AllUsers/menuId/SignIns

https://entra.microsoft.com/#view/Microsoft_AAD_IAM/AddGroup.ReactView

# Gruppo creato 
Nome                        ID
--------------------------  ------------------------------------
grp-cea-readers-<suffisso>  ***
# membro
@odata.type            DisplayName    UserPrincipalName
---------------------  -------------  ---------------------------------------
#microsoft.graph.user  cea-lab         
cea-lab@<TENANT>.onmicrosoft.com

Role    PrincipalType    Scope
------  ---------------  ---------------------------------------------------
Owner   User             <SUBSCRIPTION_ID>

# lock
resourceGroups/LAB_RG'. Please remove the lock and try again.
Code: ScopeLocked

Nome             Livello
---------------  ------------
lock-cea-delete  CanNotDelete


# Costi

ConsumedService    InstanceName    Product          Subscription
-----------------  --------------  ---------------  ------------------
Microsoft.Storage  <storage>       Files - LRS       <SUBSCRIPTION>
Microsoft.Compute  <vm>             Rtn Preference    <SUBSCRIPTION>

# Budget

Amount    Category    Name       TimeGrain
--------  ---------  ---------  ---------
20.0      Cost        <budget>   Monthly

# budget
Amount    Category    ETag               Name       TimeGrain
--------  ----------  -----------------  ---------  -----------
20.0      Cost        "1dd404135619b5e"  undefined  Monthly

# 
  --scope "$RG_SCOPE" \
  --include-inherited \
  --query "[].{Role:roleDefinitionName,PrincipalType:principalType,Scope:scope}" \
  --output jsonc \
  | sed -E 's#/subscriptions/[^/]+#/subscriptions/<omitted>#g'
[
  {
    "PrincipalType": "User",
    "Role": "Owner",
    "Scope": "/subscriptions/<omitted>
  }
]