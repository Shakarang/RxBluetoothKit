import Foundation
import RxSwift
import CoreBluetooth

public final class CentralManager: CentralManagerType {

    public let cbCentralManager: CBCentralManager

    init(cbCentralManager: CBCentralManager) {
        self.cbCentralManager = cbCentralManager
    }
    //TODO: Think about rx_ prefix - we should probably get rid of it and use Reactive from RxSwift
    /// Observable which emits state changes of central manager after subscriptions
    var rx_didUpdateState: Observable<BluetoothState> {
        return .empty()
    }

    /// Current state of Central Manager
    var state: BluetoothState {
        return BluetoothState(rawValue: cbCentralManager.state.rawValue) ?? .unsupported
    }

    func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String:Any]?) {
        cbCentralManager.scanForPeripherals(withServices: serviceUUIDs, options: options)
    }

    func connect(_ peripheral: Peripheral, options: [String:Any]?) {
        cbCentralManager.connect(peripheral.cbPeripheral, options: options)
    }

    //TODO: This method will not be available
    func cancelPeripheralConnection(_ peripheral: Peripheral) {
        cbCentralManager.cancelPeripheralConnection(peripheral.cbPeripheral)
    }

    func stopScan() {
        cbCentralManager.stopScan()
    }

    //TODO: In the future we should return `ConnectedPeripheral` instance. 
    func retrieveConnectedPeripherals(withServices serviceUUIDs: [CBUUID]) -> Observable<[Peripheral]> {
        return .just(cbCentralManager.retrieveConnectedPeripherals(withServices: serviceUUIDs).map(Peripheral.init))
    }

    func retrievePeripherals(withIdentifiers identifiers: [UUID]) -> Observable<[Peripheral]> {
        return .just(cbCentralManager.retrievePeripherals(withIdentifiers: identifiers).map(Peripheral.init))
    }
}