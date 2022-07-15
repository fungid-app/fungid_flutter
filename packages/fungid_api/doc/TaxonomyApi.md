# fungid_api.api.TaxonomyApi

## Load the API package
```dart
import 'package:fungid_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAllSpeciesTaxonomySpeciesGet**](TaxonomyApi.md#getallspeciestaxonomyspeciesget) | **GET** /taxonomy/species/ | Get All Species
[**getSpeciesTaxonomySpeciesNameOrIdGet**](TaxonomyApi.md#getspeciestaxonomyspeciesnameoridget) | **GET** /taxonomy/species/{name_or_id} | Get Species


# **getAllSpeciesTaxonomySpeciesGet**
> PageSpecies getAllSpeciesTaxonomySpeciesGet(page, size)

Get All Species

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getTaxonomyApi();
final int page = 56; // int | 
final int size = 56; // int | 

try {
    final response = api.getAllSpeciesTaxonomySpeciesGet(page, size);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TaxonomyApi->getAllSpeciesTaxonomySpeciesGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **int**|  | [optional] [default to 1]
 **size** | **int**|  | [optional] [default to 50]

### Return type

[**PageSpecies**](PageSpecies.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSpeciesTaxonomySpeciesNameOrIdGet**
> Species getSpeciesTaxonomySpeciesNameOrIdGet(nameOrId)

Get Species

### Example
```dart
import 'package:fungid_api/api.dart';

final api = FungidApi().getTaxonomyApi();
final String nameOrId = nameOrId_example; // String | 

try {
    final response = api.getSpeciesTaxonomySpeciesNameOrIdGet(nameOrId);
    print(response);
} catch on DioError (e) {
    print('Exception when calling TaxonomyApi->getSpeciesTaxonomySpeciesNameOrIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **nameOrId** | **String**|  | 

### Return type

[**Species**](Species.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

