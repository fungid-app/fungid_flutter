# fungid_api.api.ClassifierApi

## Load the API package
```dart
import 'package:fungid_api/api.dart';
```

All URIs are relative to *https://api.fungid.app*

Method | HTTP request | Description
------------- | ------------- | -------------
[**evaluateFullClassifierClassifierFullPut**](ClassifierApi.md#evaluatefullclassifierclassifierfullput) | **PUT** /classifier/full | Evaluate Full Classifier
[**evaluateImageClassifierClassifierImagePut**](ClassifierApi.md#evaluateimageclassifierclassifierimageput) | **PUT** /classifier/image | Evaluate Image Classifier
[**evaluateLocationClassifierClassifierLocationGet**](ClassifierApi.md#evaluatelocationclassifierclassifierlocationget) | **GET** /classifier/location | Evaluate Location Classifier
[**evaluateTabularClassifierClassifierTabularGet**](ClassifierApi.md#evaluatetabularclassifierclassifiertabularget) | **GET** /classifier/tabular | Evaluate Tabular Classifier
[**getVersionClassifierVersionGet**](ClassifierApi.md#getversionclassifierversionget) | **GET** /classifier/version | Get Version


# **evaluateFullClassifierClassifierFullPut**
> FullPredictions evaluateFullClassifierClassifierFullPut(date, lat, lon, images)

Evaluate Full Classifier

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getClassifierApi();
final DateTime date = 2013-10-20T19:20:30+01:00; // DateTime | 
final num lat = 8.14; // num | 
final num lon = 8.14; // num | 
final BuiltList<MultipartFile> images = /path/to/file.txt; // BuiltList<MultipartFile> | 

try {
    final response = api.evaluateFullClassifierClassifierFullPut(date, lat, lon, images);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ClassifierApi->evaluateFullClassifierClassifierFullPut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **DateTime**|  | 
 **lat** | **num**|  | 
 **lon** | **num**|  | 
 **images** | [**BuiltList&lt;MultipartFile&gt;**](MultipartFile.md)|  | 

### Return type

[**FullPredictions**](FullPredictions.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **evaluateImageClassifierClassifierImagePut**
> BuiltMap<String, num> evaluateImageClassifierClassifierImagePut(images)

Evaluate Image Classifier

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getClassifierApi();
final BuiltList<MultipartFile> images = /path/to/file.txt; // BuiltList<MultipartFile> | 

try {
    final response = api.evaluateImageClassifierClassifierImagePut(images);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ClassifierApi->evaluateImageClassifierClassifierImagePut: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **images** | [**BuiltList&lt;MultipartFile&gt;**](MultipartFile.md)|  | 

### Return type

**BuiltMap&lt;String, num&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **evaluateLocationClassifierClassifierLocationGet**
> BuiltMap<String, num> evaluateLocationClassifierClassifierLocationGet(lat, lon)

Evaluate Location Classifier

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getClassifierApi();
final num lat = 8.14; // num | 
final num lon = 8.14; // num | 

try {
    final response = api.evaluateLocationClassifierClassifierLocationGet(lat, lon);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ClassifierApi->evaluateLocationClassifierClassifierLocationGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **lat** | **num**|  | 
 **lon** | **num**|  | 

### Return type

**BuiltMap&lt;String, num&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **evaluateTabularClassifierClassifierTabularGet**
> BuiltMap<String, num> evaluateTabularClassifierClassifierTabularGet(date, lat, lon)

Evaluate Tabular Classifier

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getClassifierApi();
final DateTime date = 2013-10-20T19:20:30+01:00; // DateTime | 
final num lat = 8.14; // num | 
final num lon = 8.14; // num | 

try {
    final response = api.evaluateTabularClassifierClassifierTabularGet(date, lat, lon);
    print(response);
} catch on DioError (e) {
    print('Exception when calling ClassifierApi->evaluateTabularClassifierClassifierTabularGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **date** | **DateTime**|  | 
 **lat** | **num**|  | 
 **lon** | **num**|  | 

### Return type

**BuiltMap&lt;String, num&gt;**

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVersionClassifierVersionGet**
> ClassifierVersion getVersionClassifierVersionGet()

Get Version

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getClassifierApi();

try {
    final response = api.getVersionClassifierVersionGet();
    print(response);
} catch on DioError (e) {
    print('Exception when calling ClassifierApi->getVersionClassifierVersionGet: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**ClassifierVersion**](ClassifierVersion.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

