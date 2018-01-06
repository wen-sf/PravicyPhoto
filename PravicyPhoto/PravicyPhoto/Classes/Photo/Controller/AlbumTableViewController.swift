//
//  AlbumTableViewController.swift
//  PravicyPhoto
//
//  Created by HongXiangWen on 2017/12/30.
//  Copyright © 2017年 WHX. All rights reserved.
//

import UIKit
import CoreData

class AlbumTableViewController: UITableViewController {

    // MARK: - 公开属性
    @IBOutlet weak var editItem: UIBarButtonItem!
    @IBOutlet weak var addItem: UIBarButtonItem!
    
    // MARK: - 私有属性
    private lazy var fetchResultedController : NSFetchedResultsController<NSFetchRequestResult> = { [unowned self] in
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Album")
        let dateSort = NSSortDescriptor(key: "sort", ascending: true)
        request.sortDescriptors = [dateSort]
        let fetchResultedController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: appDelegate.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultedController.delegate = self
        return fetchResultedController
    }()

    private var confirmAction: UIAlertAction?
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadAlbums()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 显示导航条
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // MARK -- segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "pushToPhotoVC" :
            let photoVC = segue.destination as! PhotoCollectionViewController
            photoVC.album = sender as? Album
        default:
            break
        }
    }
    
}

// MARK: - UI
extension AlbumTableViewController {

    private func setupUI() {
        tableView.separatorColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.tableFooterView = UIView()
        tableView.allowsSelectionDuringEditing = true
    }
    
}

// MARK: - 私有方法
extension AlbumTableViewController {
    
    /// 加载相册
    private func loadAlbums() {
        do {
            try fetchResultedController.performFetch()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        if fetchResultedController.sections?[0].numberOfObjects == 0 {
            addAlbum("默认相册", sort: 1)
        }
    }
    
    /// 新建相册
    private func addAlbum(_ name: String, sort: Int16) {
        let album = NSEntityDescription.insertNewObject(forEntityName: "Album", into: appDelegate.persistentContainer.viewContext) as! Album
        album.albumId = CommonTool.getUUIDString()
        album.name = name
        album.coverPath = nil
        album.createAt = Date()
        album.sort = sort
        appDelegate.saveContext()
    }
    
    /// 删除相册
    private func deleteAlbum(_ album: Album) {
        appDelegate.persistentContainer.viewContext.delete(album)
        appDelegate.saveContext()
    }
    
    /// 弹出添加alert
    private func showAddAlert() {
        let alertVC = UIAlertController(title: "新建相册", message: nil, preferredStyle: .alert)
        alertVC.view.tintColor = UIColor.themeColor()
        alertVC.addTextField { (textField) in
            textField.placeholder = "输入相册名称"
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        confirmAction = UIAlertAction(title: "新建", style: .default, handler: { (action) in
            let sectionInfo = self.fetchResultedController.sections![0]
            var sort: Int16
            if sectionInfo.numberOfObjects > 0 {
                let indexPath = IndexPath(row: sectionInfo.numberOfObjects - 1, section: 0)
                let album = self.fetchResultedController.object(at: indexPath) as! Album
                sort = album.sort + 1
            } else {
                sort = 1
            }
            let textField = alertVC.textFields![0] as UITextField
            self.addAlbum(textField.text!, sort: sort)
        })
        confirmAction?.isEnabled = false
        alertVC.addAction(cancelAction)
        alertVC.addAction(confirmAction!)
        present(alertVC, animated: true, completion: nil)
    }
    
    /// 弹出删除alert
    private func showDeleteAlert(_ album: Album) {
        let alertVC = UIAlertController.init(title: "删除相册将同时删除其中的照片", message: nil, preferredStyle: .actionSheet)
        alertVC.view.tintColor = UIColor.themeColor()
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirmAction = UIAlertAction.init(title: "删除所选相册", style: .destructive, handler: { (action) in
            self.deleteAlbum(album)
        })
        alertVC.addAction(cancelAction)
        alertVC.addAction(confirmAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    /// 弹出更新alert
    private func showUpdateAlert(_ album: Album) {
        let alertVC = UIAlertController(title: "重命名", message: nil, preferredStyle: .alert)
        alertVC.view.tintColor = UIColor.themeColor()
        alertVC.addTextField { (textField) in
            textField.placeholder = "输入相册名称"
            textField.text = album.name
            textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        confirmAction = UIAlertAction(title: "新建", style: .default, handler: { (action) in
            let textField = alertVC.textFields![0] as UITextField
            album.name = textField.text
            appDelegate.saveContext()
        })
        confirmAction?.isEnabled = false
        alertVC.addAction(cancelAction)
        alertVC.addAction(confirmAction!)
        present(alertVC, animated: true, completion: nil)
    }
    
    /// 监听输入
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField.text!.count > 0 {
            confirmAction?.isEnabled = true
        } else {
            confirmAction?.isEnabled = false
        }
    }
    
}

// MARK: - Actions
extension AlbumTableViewController {
    
    @IBAction func editItemClick(_ sender: UIBarButtonItem) {
        tableView.setEditing(!self.tableView.isEditing, animated: true)
        if tableView.isEditing {
            editItem.title = "完成"
        } else {
            editItem.title = "编辑"
        }
    }
    
    @IBAction func menuItemClick(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func addItemClick(_ sender: UIBarButtonItem) {
        showAddAlert()
    }
    
}

// MARK: - UITableViewDataSource,UITableViewDelegate
extension AlbumTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultedController.sections?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultedController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kAlbumTableViewCell, for: indexPath) as! AlbumTableViewCell
        let album = fetchResultedController.object(at: indexPath) as! Album
        cell.album = album
        return cell
    }
    
    // MARK: - 点击
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let album = fetchResultedController.object(at: indexPath) as! Album
        if tableView.isEditing {
            showUpdateAlert(album)
        } else {
            performSegue(withIdentifier: "pushToPhotoVC", sender: album)
        }
    }
    
    // MARK: - 删除
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let album = fetchResultedController.object(at: indexPath) as! Album
            showDeleteAlert(album)
        }
    }
    
    // MARK: - 移动
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let sourceAlbum = fetchResultedController.object(at: sourceIndexPath) as! Album
        let destinationAlbum = fetchResultedController.object(at: destinationIndexPath) as! Album
        let sourceSort = sourceAlbum.sort
        let destinationSort = destinationAlbum.sort
        sourceAlbum.sort = destinationSort
        if sourceIndexPath.row > destinationIndexPath.row {
            if sourceIndexPath.row - destinationIndexPath.row == 1 {
                destinationAlbum.sort = sourceSort
            } else {
                for i in destinationIndexPath.row ... sourceIndexPath.row - 1 {
                    let indexPath = NSIndexPath(row: i, section: 0) as IndexPath
                    let album = fetchResultedController.object(at: indexPath) as! Album
                    album.sort = album.sort + 1
                }
            }
        } else if sourceIndexPath.row < destinationIndexPath.row {
            if destinationIndexPath.row - sourceIndexPath.row == 1 {
                destinationAlbum.sort = sourceSort
            } else {
                for i in sourceIndexPath.row + 1 ... destinationIndexPath.row {
                    let indexPath = NSIndexPath(row: i, section: 0)  as IndexPath
                    let album = fetchResultedController.object(at: indexPath) as! Album
                    album.sort = album.sort - 1
                }
            }
        }
        appDelegate.saveContext()
    }
    
}

// MARK: - NSFetchedResultsControllerDelegate
extension AlbumTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    // 哪些object发生了什么样的变化（插入，删除，更新还是移动）以及会影响哪些index
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .automatic)
        default:
            tableView.reloadData()
        }
    }
    
    // 应用这些变化
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

