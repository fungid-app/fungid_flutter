# fungid_api.api.DefaultApi

## Load the API package
```dart
import 'package:fungid_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**healthcheckHealthcheckGet**](DefaultApi.md#healthcheckhealthcheckget) | **GET** /healthcheck | Healthcheck


# **healthcheckHealthcheckGet**
> JsonObject healthcheckHealthcheckGet()

Healthcheck

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getDefaultApi();

try {
    final response = api.healthcheckHealthcheckGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling DefaultApi->healthcheckHealthcheckGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**JsonObject**](JsonObject.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

