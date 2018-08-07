import UIKit
import SDWebImage
import Reusable
import Cosmos
import youtube_ios_player_helper

private struct Constant {
    static let spaceItem = CGFloat(0)
    static let spaceLine = CGFloat(0)
}

private enum tagCollectionView: Int {
    case actor = 1
    case crew = 2
}

class MovieDetailViewController: UIViewController {
    // MARK: OUTLET
    @IBOutlet private weak var infoView: UIView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleMovie: UILabel!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var voteLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var popularLabel: UILabel!
    
    // MARK: reviewTrailerView
    @IBOutlet weak var heightConstraintView: NSLayoutConstraint!
    @IBOutlet private weak var reviewTrailerView: UIView!
    @IBOutlet private weak var reviewLabel: UILabel!
    @IBOutlet private weak var youtubePlayer: YTPlayerView!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    // MARK: ActorView
    @IBOutlet private weak var actorView: UIView!
    @IBOutlet private weak var actorCollectionView: UICollectionView!
    
    // MARK: Credit
    @IBOutlet private weak var crewView: UIView!
    @IBOutlet private weak var crewCollectionView: UICollectionView!
    
    //MARK: VARIABLES
    var movie: Movie?
    var actors = [Credit]()
    var crews = [Credit]()
    var keys = [KeyTrailer]()
    private let moviesRepository: MovieRepository = MovieRepositoryImpl(api: APIService.share)
    
    //MARK: FUNCION
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        if HandlingMoviesDatabase.checkData(movie: movie!) == nil {
            HandlingMoviesDatabase.insertMovie(movie: movie!)
            print("Insert Success")
        }
    }
    
    private func setup() {
        actorCollectionView.register(cellType: CreditCollectionViewCell.self)
        crewCollectionView.register(cellType: CreditCollectionViewCell.self)
        actorCollectionView.tag = tagCollectionView.actor.rawValue
        crewCollectionView.tag = tagCollectionView.crew.rawValue
        borderViews(views: infoView, reviewTrailerView, actorView, crewView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.showHud("Loading")
    }
    
    private func loadData() {
        guard let poster = movie?.posterPath,
            let title = movie?.title,
            let url = URL(string: URLs.posterImage + poster),
            let vote = movie?.vote,
            let overview = movie?.overview,
            let releaseDate = movie?.releaseDate,
            let popular = movie?.popularity
            else { return }
        titleMovie.text = title
        posterImageView.sd_setImage(with: url, completed: nil)
        cosmosView.rating = vote / 2
        voteLabel.text = "( " + String(vote) + " )"
        dateLabel.text = "Release date: " + releaseDate
        popularLabel.text = "Popularity: " + String(popular)
        reviewLabel.text = overview
        loadWithApi()
    }
    
    private func loadWithApi() {
        guard let id = movie?.id else { return }
        moviesRepository.getKeyTrailer(id: id) { (resultKeys) in
            switch resultKeys {
            case .success(let keyRespone):
                guard let keys = keyRespone?.keyTrailers else { return }
                self.keys = keys
                self.getTrailer()
            case .failure( _):
                print("ERROR KEY")
            }
        }
        moviesRepository.getCredit(id: id) { (resultCredits) in
            switch resultCredits {
            case .success(let creditRespone):
                guard let casts = creditRespone?.casts, let crews = creditRespone?.crews
                    else { return }
                self.actors = casts
                self.crews = crews
                self.actorCollectionView.reloadData()
                self.crewCollectionView.reloadData()
            case .failure( _):
                print("ERROR CREDIT")
            }
        }
    }
    
    private func getTrailer() {
        guard let key = keys.first?.key else { return }
        youtubePlayer.load(withVideoId: key)
        self.hideHUD()
    }
    
    //MARK: ACTION
    @IBAction private func seeMoreTappedButton(_ sender: Any) {
        guard let height = reviewLabel.text?.height(withConstrainedWidth: reviewLabel.frame.width, font: UIFont.systemFont(ofSize: 17)) else { return }
        heightConstraintView.constant = height
        seeMoreButton.isHidden = true
        youtubePlayer.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor).isActive = true
    }
    
    @IBAction private func backTappedButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case tagCollectionView.actor.rawValue:
            return actors.count
        case tagCollectionView.crew.rawValue:
            return crews.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case tagCollectionView.actor.rawValue:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CreditCollectionViewCell.self) as CreditCollectionViewCell
            let item = actors[indexPath.row]
            cell.updateCell(credit: item)
            return cell
        case tagCollectionView.crew.rawValue:
            let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: CreditCollectionViewCell.self) as CreditCollectionViewCell
            let item = crews[indexPath.row]
            cell.updateCell(credit: item)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width * 0.3 , height: collectionView.bounds.height - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spaceItem
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.spaceLine
    }
}
